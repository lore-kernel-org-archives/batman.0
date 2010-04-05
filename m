Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Apr 2010 04:47:55 +0800
References: <201003241252.18954.lindner_marek@yahoo.de>
	<20100401172810.GA28422@Linus-Debian>
	<201004031744.28756.lindner_marek@yahoo.de>
In-Reply-To: <201004031744.28756.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004060447.56173.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] reorganized kernel interface patches (version 3)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday 03 April 2010 17:44:28 Marek Lindner wrote:
> I tried that but it does not crash at my end. Maybe you did more than you
> think to provoke this crash ? In my test setup I have 2 nodes with 3
> interfaces each. I ran your command several times without seeing any odd
> behaviour.

Ok, we found the bug and fixed it.
The sysfs changes are complete now and can be found in the trunk.

Regards,
Marek
