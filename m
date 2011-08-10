Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4E42C546.7010003@inti.gob.ar>
Date: Wed, 10 Aug 2011 14:52:06 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Multiple DHCP Gateways
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

Hi

I=B4m testing the Gateway roaming capabilities of Batman-adv (using=20
2011.1.0 version). I setted two computers as Gateway servers with DHCP=20
servers running on them and other as Gateway client, configured as class=20
3. Then i stressed individually the Gateway server=B4s links to make the=20
client choose the not stressed one. I confirmed that when te client=20
sends a layer 3 broadcast DHCP request, Batman redirects that request=20
only to the best gateway. However, when the original gateway becomes=20
worse than the alternative, and the client chooses the new one as=20
preferred (observed with batctl gwl) i noticed that the subsequent=20
request DHCP messages are sent to the original server, even if it=20
doesn=B4t have the best link.

I guess that=B4s because these subsequent DHCP requests are made as=20
Unicast to the original server and so Batman doesn=B4t redirect them, but=20
i wonder how this behavior affects the network balance, because the=20
computers would get tied always to the original DHCP and IP default=20
gateway even if they moved, right?

Thank you very much

