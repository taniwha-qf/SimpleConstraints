/*
This file is part of SimpleConstraints.

SimpleConstraints is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

SimpleConstraints is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with SimpleConstraints.  If not, see
<http://www.gnu.org/licenses/>.
*/
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

using KSP.IO;

namespace SimpleConstraints {

	public class SC_CopyLocation : PartModule
	{
		[KSPField]
		public string objectTransformName;

		[KSPField]
		public string targetTransformName;

		[KSPField]
		public float weight;

		Transform objectTransform;
		Transform targetTransform;
		Vector3 basePosition;

		public override void OnAwake ()
		{
		}

		public override void OnStart(PartModule.StartState state)
		{
			if (weight < 0) {
				weight = 0;
			} else if (weight > 1) {
				weight = 1;
			}
			objectTransform = part.FindModelTransform (objectTransformName);
			targetTransform = part.FindModelTransform (targetTransformName);
			if (objectTransform == null) {
				Debug.LogError ("SC CopyLocation: could not find object transform named " + objectTransformName);
				enabled = false;
			}
			if (targetTransform == null) {
				Debug.LogError ("SC CopyLocation: could not find target transform named " + targetTransformName);
				enabled = false;
			}
			if (!enabled) {
				return;
			}
			basePosition = objectTransform.localPosition;
		}

		void Update ()
		{
			objectTransform.localPosition = basePosition * (1 - weight) + targetTransform.localPosition * weight;
		}
	}
}
