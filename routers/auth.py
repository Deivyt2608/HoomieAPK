
from fastapi import APIRouter, Form, HTTPException, Depends
from sqlalchemy.orm import Session
from database.connection import SessionLocal
from models.user import User

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/api/login")
def api_login(email_usuario: str = Form(...), pass_usuario: str = Form(...), db: Session = Depends(get_db)):
    usuario = db.query(User).filter(User.email == email_usuario).first()
    if not usuario or usuario.password != pass_usuario:
        raise HTTPException(status_code=401, detail="Correo o contraseña incorrectos")

    return {"id": usuario.id, "email": usuario.email, "nombre": usuario.nombre}
