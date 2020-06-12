mesh is stored as a series of arrays that store all the information
about the vertices and normals.

= Vertex Array + Normal Array + UV Array (How a texture is wrapped onto a model) + Triangle Array (each individual polygon triangle)

Deferred rendering: lighting is calculated at the end
Forward rendering: lighting is calculated per object when they are drawn

Calculate Dot Product in cg: half dotp = dot(IN.viewDir, o.Normal)

Vertex Versus Pixel Lighting
Vertex lit: Gouraud shading, 
Pixel lit: Phong

Lambert Lighting doesn't support specular lighting

Metallic: The quality of the surface
Specular: The light being reflected on the surface

What blend does is that it processes the pixel in the shader and the pixel in the z buffer, and then 
mix them together