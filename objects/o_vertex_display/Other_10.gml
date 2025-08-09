// Update Visible Vertices
    m_vmax = [ 1, 1, 1 ];
    m_vmin = [ -1, -1, -1];

m_vertex_count = array_length(m_vertices);
for ( var i = 0; i < m_vertex_count; i++ ) {
    var vertex = m_vertices[i];
    
    if ( vertex == -1 ) { continue; }
    vertex.f_update_orientation();

    //if ( vertex.m_id >= m_vc_min && vertex.m_id <= m_vc_max ) {
    if ( vertex.visible ) {
        if ( vertex.m_x < m_vmin[0] ) {
            m_vmin[0] = vertex.m_x;
        }
        
        else if ( vertex.m_x > m_vmax[0] ) {
            m_vmax[0] = vertex.m_x;
        }
        
        if ( vertex.m_y < m_vmin[1] ) {
            m_vmin[1] = vertex.m_y;
        }
        
        else if ( vertex.m_y > m_vmax[1] ) {
            m_vmax[1] = vertex.m_y;
        }
        
        if ( vertex.m_z < m_vmin[2] ) {
            m_vmin[2] = vertex.m_z;
        }
        
        else if ( vertex.m_z > m_vmax[2] ) {
            m_vmax[2] = vertex.m_z;
        }
  }
        

}

var camera = view_get_camera(0);
var minv = -1;
var maxv = 1;
    if ( !m_active_x ) {
        minv = min(m_vmin[1], m_vmin[2]);
        maxv = max(m_vmax[1],m_vmax[2]);

    }
    
    else if ( !m_active_y ) {
        minv = min(m_vmin[0], m_vmin[2]);
        maxv = max(m_vmax[0],m_vmax[2]);
      }
    
    else if ( !m_active_z ) {
        minv = min(m_vmin[0], m_vmin[1]);
        maxv = max(m_vmax[0],m_vmax[1]);
    }

        camera_set_view_pos(camera, minv - 50, minv - 50);
        camera_set_view_size(camera, 100 + (maxv - minv), 100 + (maxv - minv));

   view_set_camera(0, camera);


for ( var i = 0; i < m_vertex_count; i++ ) {
    
 }