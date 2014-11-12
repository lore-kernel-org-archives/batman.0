Return-Path: <r.krishnathiepan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20141112153130.GC10957@lunn.ch>
References: <CAEbDFcT3xFoJee3LFDxXEazJ1QS4DCkzoUSFipC6HAudHZ+O-Q@mail.gmail.com>
 <20141112042905.GB31881@lunn.ch>
 <CAEbDFcSO7RpyBmVmXk9dbfiLpQ8srbrHgksCtkDRB_9iAifWCQ@mail.gmail.com>
 <20141112153130.GC10957@lunn.ch>
Date: Wed, 12 Nov 2014 23:08:19 +0530
Message-ID: <CAEbDFcR+yAPSp2LnSDMNTy3xGDJhjQMWEwgYrX=P9GcxpLi=sA@mail.gmail.com>
From: Krishnathiepan Rasanayagam <r.krishnathiepan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Tcp filtering in batman-adv
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

actually Andrew,
when i found that you can do port filtering in send.c i thought about
using that idea combining with kthreads to do QoS using batman-adv.
have you ever tried tc using batman-adv?
if so let me know how you did it
