using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerMovement : MonoBehaviour
{
    public float moveSpeed = 5f;

    private float gravity = -9.81f;
    private Vector3 velocity;
    
    private CharacterController controller;
    private InputAction moveAction;
    
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        controller = GetComponent<CharacterController>();
        moveAction = InputSystem.actions.FindAction("Move");
    }

    // Update is called once per frame
    void Update()
    {
        Move();
        ApplyGravity();
    }

    private void ApplyGravity()
    {
        if (controller.isGrounded && velocity.y < 0)
        {
            velocity.y = -2f;
            return;
        }
        
        velocity.y += gravity * Time.deltaTime;
        controller.Move(velocity * Time.deltaTime);
    }
    
    private void Move()
    {
        Vector2 moveInput  = moveAction.ReadValue<Vector2>();
        Vector3 moveDirection = new Vector3(moveInput.x, 0, moveInput.y);
        moveDirection = transform.TransformDirection(moveDirection);
        controller.Move(moveDirection * (moveSpeed * Time.deltaTime));
    }
}
