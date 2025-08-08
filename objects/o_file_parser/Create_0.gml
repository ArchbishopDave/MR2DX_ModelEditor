m_vertices = [];

m_valid_file = false;
m_filename = "";

m_tmd_header_start = 0;
m_tmd_data_count = 0;
m_tmd_data = [];

m_tmd_vertex_position = -1;
m_tmd_vertex_count = -1;
m_tmd_normal_position = -1;
m_tmd_normal_count = -1;
m_tmd_polygon_position = -1;
m_tmd_polygon_count = -1;

f_valid_tristrip_header = function(val1, val2) {
    if ( val1 == 1545 && val2 == 13312) { return true;} 
    if ( val1 == 1545 && val2 == 13824) { return true;} 
    return false;
 }

f_valid_quadstrip_header = function(val1, val2) {
    
    
    if ( val1 == 2060 && val2 == 15360 ) { return true; }
     return false;
}
