Return-Path: <cmsv@wirelesspt.net>
Message-ID: <5313B316.701@wirelesspt.net>
Date: Sun, 02 Mar 2014 17:39:18 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <CANHt3YGgN754sR4V2v0jpgMoTSSg0OVmGMOTRQ3zrF8dS5mA_Q@mail.gmail.com>
In-Reply-To: <CANHt3YGgN754sR4V2v0jpgMoTSSg0OVmGMOTRQ3zrF8dS5mA_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Network coding multi-hop bandwidth loss
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I just found out /(the hard way) that using network coding (batman-adv
2013.4) that i have a massive, unbelievable bandwidth loss if i have
more than one hop to the destination

I tested this in a real scenario with 11 nodes as well as 3 nodes in a
house with 3 floors and having one per each floor.

Here is the example with 3 nodes

A <------ B -----> C

From node B to iperf reports me 15 mbit
From node B to node C iperf reports me 9 mbit

Then, from node C to node A i get values bellow 1 mbit such as 647kbits
or less.
More than 3 nodes is to forget.

uci set batman-adv.bat0.network_coding=0 disables nc and solved the
problem which brought the network bandwidth to a more realistic and
mathematical acceptable bandwidth level.

Is this finding known by others ?



-- 


Site: http://wirelesspt.net
Mesh: http://tinyurl.com/wirelesspt
Admin: http://wirelesspt.net/wiki/Cmsv
Twitter: http://twitter.com/wirelesspt
Youtube: https://youtube.com/wirelesspt
Facebook: https://www.facebook.com/wirelesspt
Suporte técnico via sms: 91 19 11 798
Donativos/Paypal: http://tinyurl.com/doar-verba
Chave publica PGP/SSH: http://wirelesspt.net/arquivos/pk
Email ao abrigo de: https://creativecommons.org/licenses/by-nc-sa/3.0/pt/



