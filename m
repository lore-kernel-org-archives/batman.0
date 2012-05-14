Return-Path: <onelektra@gmx.net>
Date: Mon, 14 May 2012 18:42:54 +0200
From: Elektra <onelektra@gmx.net>
Message-Id: <20120514184254.f79056e44db765d4f85b4f75@gmx.net>
In-Reply-To: <1337010808.2814.70.camel@E-PC-JJ>
References: <1337010808.2814.70.camel@E-PC-JJ>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Some problems with batman-adv
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello Jochen -

welcome to driver & firmware hell. This is very likely a problem related to stability issues with your WiFi interfaces. I would expect this behavior since you are using USB WiFi dongles. All USB WiFi devices depend on firmware, which is loaded when you initialize the devices. Ad-hoc mode has been neglected far and wide by the industry. Since you have to load a proprietary binary blob, which is more likely broken in ad-hoc mode rather than not, I am afraid you are out of luck. I'd love to get a USB WiFi solution in my hands that actually works in a reliable and stable manner. Unfortunately I know of none.

If anybody has something that actually works, I'd love to know.

Cheers,
Elektra
