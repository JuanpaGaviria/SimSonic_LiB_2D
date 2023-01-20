function TotalGeometry = Geometry_Final(ID, grid_step_mm, index, TotalGeometry_old)
    N1 = evalin('base','N1');N2 = evalin('base','N2');
    disk_diameter_pt = round(ID/grid_step_mm+1);
    SE = strel('disk', round((disk_diameter_pt+1)/2),0);
    scatterer = getnhood(SE)*index;
    [M1,M2] = size(scatterer);
    geometry = uint8(zeros(N1,N2)); 
    geometry((N1-M1)/2+1:(N1+M1)/2,(N2-M2)/2+1:(N2+M2)/2) = uint8(scatterer);
    TotalGeometry = TotalGeometry_old + geometry;
end