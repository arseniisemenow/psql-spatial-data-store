#include <pqxx/pqxx>
#include <iostream>
#include <vector>

int main() {
  try {
    pqxx::connection conn("dbname=spatialdatadb user=spatialdatauser password=spatialdatapassword host=db port=5432");

    pqxx::work txn(conn);

    // Prepare a statement to retrieve data in binary format
    conn.prepare("get_node_data",
                 "SELECT node_id, parent_id, level, has_lod, ST_AsBinary(bounds) FROM nodes WHERE node_id = $1");

    // Execute the prepared statement
    int node_id_to_query = 1;  // For example purposes
    pqxx::result r = txn.exec_prepared("get_node_data", node_id_to_query);

    // Process the binary data
    for (auto row : r) {
      int node_id = row[0].as<int>();        // Extraction of integer
      int parent_id = row[1].as<int>();      // Extraction of integer
      int level = row[2].as<int>();          // Extraction of integer
      bool has_lod = row[3].as<bool>();      // Extraction of boolean
      std::string bounds_binary = row[4].as<std::string>(); // Extract binary geometry data

      // Output binary data (for demonstration purposes, actual geometry parsing would be required here)
      std::cout << "Node ID: " << node_id << ", Parent ID: " << parent_id
                << ", Level: " << level << ", Has LOD: " << has_lod
                << ", Bounds (binary): " << bounds_binary << std::endl;
    }

    txn.commit();

  } catch (const std::exception &e) {
    std::cerr << e.what() << std::endl;
  }

  return 0;
}
