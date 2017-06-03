Return-Path: <xbing6@gmail.com>
References: <edc163f6-a49c-21f3-9cf1-74df6e262fdb@gmail.com>
 <CAJ-Vmo=4-wKKV_4pXTSgVqdPOyR+zOrHbtVP4Mv9vxaueyrh=A@mail.gmail.com>
 <c9f21f91-992d-604f-91ac-4784e8258c3e@gmail.com>
 <CAJ-Vmo=RnRGCEOTs6VHzTVZeex0n7OnTEiJq8jZR2cDhbnTXwA@mail.gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <458fa88b-b6d9-d02a-8d5f-012f6c83edef@gmail.com>
Date: Sat, 3 Jun 2017 14:30:27 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ-Vmo=RnRGCEOTs6VHzTVZeex0n7OnTEiJq8jZR2cDhbnTXwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [B.A.T.M.A.N.] [wpa_supplicant] Is there a way to limit peers
 (to about 12) for IBSS/adhoc?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Adrian Chadd <adrian@freebsd.org>
Cc: hostap@lists.infradead.org, Jason Toschlog <jason.toschlog@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>, simon Wunderlich <sw@simonwunderlich.de>

Hi Adrian,

=> Is it a gradual thing?  Ie, do you know when it starts to hang? Does
it hang at 40? or gradually as you approach 40?

We do not know. What we do know is, 20 peers / neighbors work well.

Jason Toschlog in CC said that he observed similar issues with brcmfmac 
when peers reach 32 (16 peers work for him).

I guess I will setup 32 or 40 nodes here and try limit the max number of 
peers (at wpa_supplicant) for IBSS/adhoc.

Thanks again.

Xuebing Wang

On 2017年06月03日 14:16, Adrian Chadd wrote:
> Hi,
>
> Well, it sounds like something you need a 40 node test network for :)
>
> I was wondering whether it was some kind of MAC bug that was being
> triggered because of so many units say, overflowing the keycache or
> something. But if it's software encryption then maybe not. I wish I
> could help more, but setting up a 40 node network to test is a big
> challenge. :)
>
> Is it a gradual thing?  Ie, do you know when it starts to hang? Does
> it hang at 40? or gradually as you approach 40?
>
> As for association limits - I thought there was a maximum station
> parameter somewhere...
>
>
> -adrian
>

