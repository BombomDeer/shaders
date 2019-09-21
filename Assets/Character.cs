using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Character : MonoBehaviour
{
    Vector3 endPos = Vector3.zero;
    public float fSpeed = 10.0f;

    
    // Start is called before the first frame update
    void Start()
    {        
        transform.position = Vector3.zero;
        endPos = transform.position;
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButton(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit raycastHit;
            if(Physics.Raycast(ray, out raycastHit))
            {
                if (raycastHit.transform.tag == "terrain")
                {
                    endPos = raycastHit.point;
                }
            }

            transform.position = Vector3.MoveTowards(transform.position, endPos, Time.deltaTime * fSpeed);   
        }
        
    }
}
