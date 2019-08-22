/****************************************************************************
 * Copyright (c) 2018.12 liangxie
 * 
 * http://liangxiegame.com
 * https://github.com/liangxiegame/QFramework
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ****************************************************************************/

using System.Collections.Generic;
using UnityEngine;

namespace QF.Action
{
	[MonoSingletonPath("[ActionKit]/ActionQueue")]
	public class ActionQueue : MonoBehaviour,ISingleton
	{
		private List<IAction> mActions = new List<IAction>();

		public static void Append(IAction action)
		{
			mInstance.mActions.Add(action);
		}

		// Update is called once per frame
		private void Update()
		{
			if (mActions.Count != 0 && mActions[0].Execute(Time.deltaTime))
			{
				mActions.RemoveAt(0);
			}
		}

		void ISingleton.OnSingletonInit()
		{
		}

		private static ActionQueue mInstance
		{
			get { return MonoSingletonProperty<ActionQueue>.Instance; }
		}
	}
}