Return-Path: <martin@hundeboll.net>
Message-ID: <54533A03.7070807@hundeboll.net>
Date: Fri, 31 Oct 2014 08:28:03 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <CAEbDFcTj0b0-i+eTcgrksRFWbw6fNJWpo79QnURHAzgWYOR04g@mail.gmail.com>
In-Reply-To: <CAEbDFcTj0b0-i+eTcgrksRFWbw6fNJWpo79QnURHAzgWYOR04g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Reading batman-adv buffer
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
To: "r.krishnathiepan@gmail.com >> Krishnathiepan Rasanayagam" <r.krishnathiepan@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Krisna,

On 2014-10-31 05:12, Krishnathiepan Rasanayagam wrote:
> Hi all,
>
> Does anyone knows how we can read data from batman-adv transmission
> buffer. before it transmits. Can we change the buffer ?
> Any details about the way batman-adv is using the buffer is valuable.

There is no buffering taking place in batman-adv (unless you use network 
coding). It simply takes whatever comes in from either neighboring nodes 
or the virtual interface, and puts it in the relevant queue *outside* 
batman-adv. For outgoing (or forwarded) packets this is the tx-queue of 
the underlying interface (e.g. the one that is controlled with 'ip link 
set dev wlan0 txqlen'). For incoming packets, it is the rxqueue of the 
virtual interface (bat0), if one such exists.

Hope this helps!

-- 
Kind Regards,
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
