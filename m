Return-Path: <xbing6@gmail.com>
References: <edc163f6-a49c-21f3-9cf1-74df6e262fdb@gmail.com>
 <CAJ-Vmo=4-wKKV_4pXTSgVqdPOyR+zOrHbtVP4Mv9vxaueyrh=A@mail.gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <c9f21f91-992d-604f-91ac-4784e8258c3e@gmail.com>
Date: Sat, 3 Jun 2017 13:28:56 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ-Vmo=4-wKKV_4pXTSgVqdPOyR+zOrHbtVP4Mv9vxaueyrh=A@mail.gmail.com>
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

Thanks.

I did not try 40 IBSS nodes without encryption. I am using software 
encryption for ath9k because of key caching issues discussed in below 
threads:
https://patchwork.kernel.org/patch/9381651/
https://github.com/cozybit/authsae/issues/42

This is a customer site in the field, our temporary work-around is to 
create 2 networks (each is with 20 nodes) by using different SSID.

Because this is customer site in the field, it is not convenient to 
change and test. Does it make sense to test without encryption, 
encryption is a MUST?

Xuebing Wang

On 2017年06月03日 13:18, Adrian Chadd wrote:
> Hi!
>
> Does it happen if you run 40 IBSS nodes without encryption?
>
> (I wonder if it's a MAC or PHY bug..)
>
>
> -adrian
>

