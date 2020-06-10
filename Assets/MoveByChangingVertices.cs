using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveByChangingVertices : MonoBehaviour
{
    private Mesh mesh;
    private Vector3[] vertices;

    private void Start()
    {
        mesh = GetComponent<MeshFilter>().mesh;
        vertices = mesh.vertices;
    }

    private void Update()
    {
        for (int i = 0; i < vertices.Length; i++)
        {
            vertices[i] += Vector3.up * Time.deltaTime;
        }

        mesh.vertices = vertices;
        mesh.RecalculateBounds();
    }
}
