using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Spinner : MonoBehaviour
{
    public Vector3 RotationPerSecond;

	void Update ()
	{
        transform.Rotate(RotationPerSecond * Time.deltaTime);
	}
	
	public void adjustRotationSpeed(float value) {
		transform.Rotate(0, value, 0, Space.Self);
	}
}