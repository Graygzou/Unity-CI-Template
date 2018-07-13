using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestMonoBehavior : MonoBehaviour {

    int life;

	// Use this for initialization
	void Start () {
        life = 0;
	}
	
	// Update is called once per frame
	void Update () {
		if (life > 3)
        {
            life = 0;
        }
        else
        {
            life++;
        }
	}
}
