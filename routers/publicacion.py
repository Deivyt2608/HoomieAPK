
from fastapi import APIRouter, Form, Depends, HTTPException
from sqlalchemy.orm import Session
from database.connection import SessionLocal
from models.publicacion import Publicacion
from models.user import User

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/api/crear-publicacion")
def api_crear_publicacion(nombre: str = Form(...), descripcion: str = Form(...), tipo_publicacion: str = Form(...), email_usuario: str = Form(...), db: Session = Depends(get_db)):
    usuario = db.query(User).filter(User.email == email_usuario).first()
    if not usuario:
        raise HTTPException(status_code=401, detail="Usuario no autenticado")

    nueva_pub = Publicacion(
        nombre=nombre,
        descripcion=descripcion,
        tipo_publicacion=tipo_publicacion,
        usuario_id=usuario.id
    )
    db.add(nueva_pub)
    db.commit()
    db.refresh(nueva_pub)

    return {"mensaje": "Publicación creada", "id": nueva_pub.id}
