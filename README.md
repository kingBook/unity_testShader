How to change Sprite uv in Unity?

```
public class SpriteUV : MonoBehaviour 
{
    private SpriteRenderer _spriteRenderer;
    private Sprite _sprite;

    [SerializeField] public Vector2[] _uv = new Vector2 [4]
    {
        new Vector2(0.4f, 0.5f),
        new Vector2(0.6f, 0.5f),
        new Vector2(0.4f, 0.35f),
        new Vector2(0.6f, 0.35f)
    }; 

    void Start ()
    {
        _spriteRenderer = GetComponent<SpriteRenderer>();
        _sprite = _spriteRenderer.sprite;
    }

    // Update is called once per frame
    void Update ()
    {
        _sprite.uv = _uv;
    }
}
```

Unity - mesh from sprite vertices
```
private Mesh SpriteToMesh(Sprite sprite)
{
    Mesh mesh = new Mesh();
    mesh.SetVertices(Array.ConvertAll(sprite.vertices, i => (Vector3)i).ToList());
    mesh.SetUVs(0,sprite.uv.ToList());
    mesh.SetTriangles(Array.ConvertAll(sprite.triangles, i => (int)i),0);

    return mesh;
}
```