using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestSprite : MonoBehaviour{
	public Sprite sprite;
	
	private SpriteRenderer m_spriteRenderer;
	private Texture2D m_texture;
	private Color[] m_pixels;
	
	
	protected void Start(){
		m_spriteRenderer=GetComponent<SpriteRenderer>();
		
		
		Vector2[] vertices=sprite.vertices;
		Vector2[] uvs=sprite.uv;
		Debug.LogFormat("vertices:{0} uvs:{1}",vertices.Length,uvs.Length);
		for(int i=0;i<uvs.Length;i++){
			Debug.LogFormat("i:{0} uv:{1} vertex:{2}",i,uvs[i],vertices[i]);
		}
	}

	protected void Update(){

	}
}
