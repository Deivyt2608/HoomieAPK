
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database.connection import SessionLocal
from models.publicacion import Publicacion

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/api/detalle/{publicacion_id}")
def api_detalle_publicacion(publicacion_id: int, db: Session = Depends(get_db)):
    publicacion = db.query(Publicacion).filter(Publicacion.id == publicacion_id).first()
    if not publicacion:
        raise HTTPException(status_code=404, detail="Publicación no encontrada")

    return {
        "id": publicacion.id,
        "nombre": publicacion.nombre,
        "descripcion": publicacion.descripcion,
        "tipo_publicacion": publicacion.tipo_publicacion,
        "usuario_id": publicacion.usuario_id
    }
