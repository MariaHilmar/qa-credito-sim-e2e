"""Exemplo de biblioteca Python customizada para Robot Framework."""


class CustomLibrary:
    """Keywords utilitárias em Python."""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def gerar_identificador(self, prefixo: str = "test") -> str:
        """Gera um identificador único para dados de teste."""
        import uuid

        return f"{prefixo}-{uuid.uuid4().hex[:8]}"
