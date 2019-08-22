using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace Render.PostEffect
{
    public class SharpPE : PostEffectsBase
    {
        [Range(0, 0.5f)]
        public float BlurOffset;

        void OnRenderImage(RenderTexture src, RenderTexture dest)
        {
            if (PEMat == null)
                return;

            PEMat.SetFloat("_BlurOffset", BlurOffset);

            Graphics.Blit(src, dest, PEMat);
        }
    }


}

