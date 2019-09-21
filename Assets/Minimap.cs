using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Minimap : MonoBehaviour
{
    public ScrollRect scrollRc;
    public GameObject player;
    public RectTransform mobTr;

    //3차원 공간상의 실제 맵 크기
    float mapXsize = 100;
    float mapZsize = 100;
    float x;
    Vector2 minimapPos;
    // Start is called before the first frame update
    void Start()
    {
        //스크롤뷰에서 위치를 조정할수있는 변수가 다
        //노멀라이즈드 ScrollRect의 normalizedPosition 변수를 사용 조종 가능하다 
        scrollRc.normalizedPosition = new Vector2(0.5f, 0.5f);// 정중앙

        mobTr.anchoredPosition = new Vector2(0,0);
    }

    Vector2 Get2DMapPosition()
    {
        Vector3 tmp = player.transform.position;
        //offset
        //미니맵의 0,0은 이미지의 중앙점
        //캐릭터의 0,0은 월드 공간상의 0,0
        tmp.x += 50;
        tmp.z += 50;

        float xRatio = tmp.x / mapXsize;
        float zRatio = tmp.z / mapZsize;

        minimapPos.Set(xRatio, zRatio);

        return minimapPos;
    }

    // Update is called once per frame
    void Update()
    {
        
        scrollRc.normalizedPosition = new Vector2(Get2DMapPosition().x, Get2DMapPosition().y);
    }
}
