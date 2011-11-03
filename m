Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
Date: Thu, 3 Nov 2011 16:53:16 +0200
Message-ID: <CAKeC-QFhm8CgyT8HwGqPwtS=E2g_2Haq3bUK2p+GZnppnwUBgQ@mail.gmail.com>
From: Wayne Abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] MTU issue
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

Hi All

We are having a small isue with mtu, on certain builds, could be only
the latest, we are getting this error in wrt.

batman_adv: bat0: The MTU of interface wlan0 is too small (1527) to
handle the transport of batman-adv packets. Packets going over this
interface will be fragmented on layer2 which could impact the
performance. Setting the MTU to 1528 would solve the problem.

I had the same issue previously, but 1528 did not do it.
I have since changed build on that unit and can't remember the actual
value I used, But it was larger.

All I did was increase the value until the warning disappeared, and
everything started working as advertised.

Any idea's?

Wayne A
