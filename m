Return-Path: <zaki.bm@gmail.com>
MIME-Version: 1.0
Date: Fri, 11 Oct 2013 11:11:04 +0800
Message-ID: <CABQkniC4b-CEdx9-7rNBuG0p5a5tM1fptsKjida0vThVUYVtug@mail.gmail.com>
From: Zaki <zaki.bm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Batman-Adv : Hops and Throughput with Collocated
	dual-radio
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I am a newbie in batman-adv.  I got a question regarding Hops and
Throughput, especially in regards with a collocated dual-radio device.
 Hopefully somebody could offer some help here for me to fully
understand batman-adv operation.  I have 3 devices, namely A, B and C.

A is only having single radio (operating at Freq 5.20G in AdHoc mode).
 Put this under bat0.  Bridge bat0 with eth0.
B is having dual-radio (radio1 operates at 5.20G in AdHoc mode, radio2
is at 5.24G in AdHoc mode). Put these under bat0. Bridge bat0 with
eth0
C is like A (single radio, operating at 5.24G in AdHoc mode). Put this
under bat0.  Bridge bat0 with eth0.

So, the wireless link will be like this :

[A]::::::::::::::: [B(radio1)---B(radio2)]::::::::::::::::[C]

1) If i were to ping from A to C, how many hops is it considered?.  Is
it 2 hops or 3 hops?.
2) If my Iperf TCP throughput from A to B is 40Mbps, what is the
expected throughput of Iperf from A to C ?.

Thanks a lot.

Jack.
