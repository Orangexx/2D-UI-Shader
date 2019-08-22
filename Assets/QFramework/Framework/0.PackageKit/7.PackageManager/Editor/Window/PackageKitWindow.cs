﻿/****************************************************************************
 * Copyright 2017 ~ 2019.2 liangxie
 * 
 * http://qframework.io
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
using System.Linq;

namespace QF.Editor
{
	using UnityEngine;
	using UnityEditor;

	public class PackageKitWindow : QEditorWindow
	{
		class LocaleText
		{
			public static string QFrameworkSettings
			{
				get { return Language.IsChinese ? "QFramework 设置" : "QFramework Settings"; }
			}
		}

		[MenuItem(FrameworkMenuItems.Preferences, false, FrameworkMenuItemsPriorities.Preferences)]
		private static void Open()
		{
			var packageKitWindow = Create<PackageKitWindow>(true);
			packageKitWindow.titleContent = new GUIContent(LocaleText.QFrameworkSettings);
			packageKitWindow.position = new Rect(100, 100, 690, 500);
			packageKitWindow.Show();
		}

		private const string URL_FEEDBACK = "http://feathub.com/liangxiegame/QFramework";

		[MenuItem(FrameworkMenuItems.Feedback, false, FrameworkMenuItemsPriorities.Feedback)]
		private static void Feedback()
		{
			Application.OpenURL(URL_FEEDBACK);
		}

		public override void OnUpdate()
		{
			mPackageKitViews.ForEach(view=>view.OnUpdate());
		}

		public List<IPackageKitView> mPackageKitViews = null;

		protected override void Init()
		{
			var label = GUI.skin.label;
			PackageApplication.Container = null;
			
			RemoveAllChidren();

			mPackageKitViews = PackageApplication.Container
				.ResolveAll<IPackageKitView>()
				.OrderBy(view => view.RenderOrder)
				.ToList();
			
			PackageApplication.Container.RegisterInstance(this);

		}
		
		public override void OnGUI()
		{
			base.OnGUI();
			mPackageKitViews.ForEach(view=>view.OnGUI());
		}

		public override void OnClose()
		{
			mPackageKitViews.ForEach(view=>view.OnDispose());
			
			RemoveAllChidren();
		}
	}	
}