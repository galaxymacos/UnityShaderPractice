using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DecalOnOff : MonoBehaviour
{
    private Material material;

    private bool showDecal = false;

    private void OnMouseDown()
    {
        showDecal = !showDecal;
        if (showDecal)
        {
            material.SetFloat("_ShowDecal",1);
        }
        else
        {
            material.SetFloat("_ShowDecal",0);
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        material = GetComponent<Renderer>().sharedMaterial;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
