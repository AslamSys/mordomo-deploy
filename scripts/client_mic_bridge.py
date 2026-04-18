import asyncio
import pyaudio
import websockets
import nats
import json
import sys

# Configurações do Áudio
CHUNK = 1600  # 100ms em 16kHz
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 16000

async def audio_bridge():
    # IP do seu Orange Pi
    ORANGEPI_IP = "192.168.1.15"  # <-- ALTERE PARA O SEU IP
    ws_url = f"ws://{ORANGEPI_IP}:3100/audio?device_id=headset_renan"
    nats_url = f"nats://{ORANGEPI_IP}:4222"

    p = pyaudio.PyAudio()
    
    try:
        # 1. Conecta ao NATS para disparar os eventos de ativação
        nc = await nats.connect(nats_url)
        print(f"📡 Conectado ao NATS em {nats_url}")

        # 2. Abrindo o Microfone do Windows
        stream = p.open(format=FORMAT, channels=CHANNELS, rate=RATE, input=True, frames_per_buffer=CHUNK)
        print(f"🎤 Microfone aberto (Rate: {RATE}Hz)")
    except Exception as e:
        print(f"❌ Erro na inicialização: {e}")
        return

    try:
        print(f"🔌 Conectando ao Websocket em {ws_url}...")
        async with websockets.connect(ws_url) as ws:
            print("✅ CONECTADO!")

            # 3. Disparar Sinais de Ativação (Simulando VAD e FaceID)
            print("🔥 Ativando Mordomo (Fake Wake Word + Speaker ID)...")
            session_id = "test-session-123"
            
            await nc.publish("mordomo.wake_word.detected", json.dumps({
                "session_id": session_id,
                "confidence": 1.0
            }).encode())
            
            # Simulamos que o Speaker ID (você) foi verificado
            await nc.publish("mordomo.speaker.verified", json.dumps({
                "speaker_id": "renan", # O ID que você vai colocar no People depois
                "confidence": 1.0,
                "session_id": session_id
            }).encode())

            print("🚀 Pipeline PRONTO. Pode falar agora!")
            print("[Ctrl+C para encerrar]")

            while True:
                data = stream.read(CHUNK, exception_on_overflow=False)
                await ws.send(data)
                
    except websockets.exceptions.ConnectionClosed:
        print("\n❌ Conexão fechada pelo servidor.")
    except KeyboardInterrupt:
        print("\n🛑 Encerrando teste.")
    except Exception as e:
        print(f"\n❌ Ocorreu um erro: {e}")
    finally:
        stream.stop_stream()
        stream.close()
        p.terminate()
        await nc.close()

if __name__ == "__main__":
    asyncio.run(audio_bridge())
