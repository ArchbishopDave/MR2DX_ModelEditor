

if ( !m_active_x ) {
    m_active_x = true;
    m_active_z = false;
    d_mode_text = "XY Projection";
}


else if ( !m_active_y ) {
    m_active_y = true;
    m_active_x = false;
    d_mode_text = "YZ Projection";
}

else {
    m_active_z = true;
    m_active_y = false;
    d_mode_text = "XZ Projection";
}


user_event(self.id, 0);