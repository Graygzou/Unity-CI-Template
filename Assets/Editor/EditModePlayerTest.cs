using UnityEngine;
using UnityEditor;
using UnityEngine.TestTools;
using NUnit.Framework;
using System.Collections;

public class PlayerTest {

	[Test]
	public void CreatePlayerEmptyLifeTest() {
        // Use the Assert class to test conditions.
        PlayerScript player = new PlayerScript();
        Assert.AreEqual(player.GetLife(), 3);
    }

    [Test]
    public void CreatePlayerEmptyPointsTest()
    {
        PlayerScript player = new PlayerScript();
        Assert.AreEqual(player.GetPoints(), 0);
    }

    // A UnityTest behaves like a coroutine in PlayMode
    // and allows you to yield null to skip a frame in EditMode
    [UnityTest]
	public IEnumerator PlayerTestWithEnumeratorPasses() {
		// Use the Assert class to test conditions.
		// yield to skip a frame
		yield return null;
	}
}
