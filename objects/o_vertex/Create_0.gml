m_id = 0;
m_group = -1;

m_x = 0;
m_y = 0;
m_z = 0;
m_q = 0;

d_color = c_white;
m_connected_vertices_count = 0;
m_connected_vertices = [];


f_update_orientation = function() {
    if ( !o_vertex_display.m_active_x ) {
        y = m_y;
        x = m_z;
        d_color = make_color_hsv(lerp(0, 220, (1000 - m_x)/2000), 255, 255);
    }
    
    else if ( !o_vertex_display.m_active_y ) {
        x = m_x;
        y = m_z;
        d_color = make_color_hsv(lerp(0, 220, (1000 - m_y)/2000), 255, 255);
    }
    
    else {
        x = m_x;
        y = m_y;
        d_color = make_color_hsv(lerp(0, 220, (1000 - m_z)/2000), 255, 255);
    }
    
    m_connected_vertices_count = array_length(m_connected_vertices);
    
    visible = ( o_vertex_display.m_group_current == -1 || o_vertex_display.m_group_current == m_group );
        
}


