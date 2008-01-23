From: Frithjof Hammer <batman@frithjof-hammer.de>
Subject: Re: [B.A.T.M.A.N.] batman OpenWRT integration
Date: Wed, 23 Jan 2008 10:42:51 +0100
References: <200801211527.04600.lindner_marek@yahoo.de>
	<200801211920.30577.an.langer@gmx.de>
	<a934d3f30801230049x78665caau3b4c657cb87521fe@mail.gmail.com>
In-Reply-To: <a934d3f30801230049x78665caau3b4c657cb87521fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801231042.52188.batman@frithjof-hammer.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hey!

I don't think its wise to use the start up number 100 for the init script. 
Actually batman will start first (S100batman sorts before S10boot) so all 
interfaces are still down.

Greetings,
Frithjof
