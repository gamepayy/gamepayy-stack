import { z } from 'zod';
import mysql from 'mysql';

/**
 * Deletes all data from all tables in the database, (except for the
 * _prisma_migrations table). This function ensures that the tables are deleted
 * in the correct order to avoid foreign key constraint errors.
 *
 * Run this between tests to ensure that the database is in a clean state. This
 * will keep your tests isolated from each other.
 *
 * NOTE: It's better than deleting the database and recreating it because it
 * doesn't require you to re-run migrations.
 */
export function deleteAllData() {
	const excludedTables = ['_prisma_migrations'];
  	const connection = mysql.createConnection(process.env.DATABASE_URL);

	connection.connect();
	// Get a list of all tables in the database
	connection.query(
		"SELECT table_name as name FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name NOT IN (?)",
		[excludedTables],
		(error: any, allTableNamesRaw: unknown) => {
		  if (error) throw error;
	
		  const allTableNames = z
			.array(z.object({ name: z.string() }))
			.parse(allTableNamesRaw)
			.map(({ name }) => name);
	
		  // Get a list of foreign key constraints for each table
		  connection.query(
			"SELECT table_name, referenced_table_name as parent_table_name FROM information_schema.key_column_usage WHERE referenced_table_name IS NOT NULL AND table_schema = DATABASE() AND table_name NOT IN (?)",
			[excludedTables],
			(error: any, foreignKeysRaw: unknown) => {
			  if (error) throw error;
	
			  const foreignKeys = z
				.array(
				  z.object({
					table_name: z.string(),
					parent_table_name: z.string(),
				  }),
				)
				.parse(foreignKeysRaw);

	// Build a dependency graph for the tables
	const graph: { [key: string]: Set<string> } = {}
	for (const tableName of allTableNames) {
		graph[tableName] = new Set()
	}
	for (const { table_name, parent_table_name } of foreignKeys) {
		graph[parent_table_name].add(table_name)
	}

	// Topologically sort the tables
	const sortedTableNames: Array<string> = []
	const visited = new Set()
	const visit = (tableName: string) => {
		if (visited.has(tableName)) {
			return
		}
		visited.add(tableName)
		for (const dependentTableName of graph[tableName]) {
			visit(dependentTableName)
		}
		sortedTableNames.push(tableName)
	}
	for (const tableName of allTableNames) {
		visit(tableName)
	}

	// Delete all data in each table in the proper order
	for (const tableName of sortedTableNames) {
		connection.query(`DELETE FROM \`${tableName}\``, (error: any) => {
		  if (error) throw error;
		});
	  }

	  connection.end();
		}
	);
  }
);
}

