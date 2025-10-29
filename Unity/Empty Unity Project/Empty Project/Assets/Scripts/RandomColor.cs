using UnityEngine;

public class RandomColor : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        Color randomColor = new Color(Random.Range(0,255),  Random.Range(0,255), Random.Range(0,255));
        
        GetComponent<Renderer>().material.color = randomColor;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
