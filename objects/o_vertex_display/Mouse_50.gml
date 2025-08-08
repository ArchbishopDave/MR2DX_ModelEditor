if ( m_current_vertex != -1 ) {
    
    if ( !m_active_x ) {
        m_current_vertex.m_y = round(mouse_y);
        m_current_vertex.m_z = round(mouse_x);
        
        m_current_vertex.y = m_current_vertex.m_y;
        m_current_vertex.x = m_current_vertex.m_z;
    }
    
    else if ( !m_active_y ) {
        m_current_vertex.m_x = round(mouse_x);
        m_current_vertex.m_z = round(mouse_y);
        
        m_current_vertex.x = m_current_vertex.m_x;
        m_current_vertex.y = m_current_vertex.m_z;
    }
    
    else {
        m_current_vertex.m_x = round(mouse_x);
        m_current_vertex.m_y = round(mouse_y);
        
        m_current_vertex.x = m_current_vertex.m_x;
        m_current_vertex.y = m_current_vertex.m_y;
    }
 }
    