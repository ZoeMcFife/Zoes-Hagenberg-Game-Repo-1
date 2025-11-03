using UnityEngine;

public class GameTimer : MonoBehaviour
{
    public GameObject timerText;
    public float timeRemaining = 10f;
    
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (timeRemaining > 0)
        {
            timeRemaining -= Time.deltaTime;
            timerText.GetComponent<TMPro.TMP_Text>().text = timeRemaining.ToString();
            Debug.Log("Time Remaing" + timeRemaining);
        }
        else
        {
            timeRemaining = 0;
            timerText.GetComponent<TMPro.TMP_Text>().text = "GAME OVER GAY ASS";
        }
        
    }
}
