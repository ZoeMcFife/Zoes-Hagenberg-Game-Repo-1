using UnityEngine;

public class CameraSlideMovement : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Debug.Log("Moew");
        
        transform.Translate(Vector3.forward * Time.deltaTime);
    }
}
