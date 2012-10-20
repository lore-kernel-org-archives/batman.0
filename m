Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20121017115604.GO7023@ritirata.org>
References: <1350473910-27496-1-git-send-email-linus.luessing@web.de>
 <20121017115604.GO7023@ritirata.org>
From: Gui Iribarren <gui@altermundi.net>
Date: Sat, 20 Oct 2012 01:18:13 -0300
Message-ID: <CAHD-aqJqCih9rZNGyOy5X8CLgysUZZs2w4vELSaKLeEq-oehhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix broadcast packet CRC
	calculation
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

[resending as plaintext since maillist refused to accept apparently a
Content-Type: text/html]

On Wed, Oct 17, 2012 at 9:42 AM, Gui Iribarren <gui@altermundi.net> wrote:
Ah, interesting! Does this affect multi-hop broadcasts as well? Maybe
this could be somehow related to the misteriously dropped avahi
packets we experience here. Nico Echaniz reported the case in a
previous thread[0] but so far we didn't have time to debug it further.
If this patch affects anything described in that mail (a couple of
months ago) we are eager to test it out :)

[0] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-July/007763.html

On Wed, Oct 17, 2012 at 8:56 AM, Antonio Quartulli <ordex@autistici.org> wr=
ote:
> On Wed, Oct 17, 2012 at 01:38:30PM +0200, Linus L=C3=BCssing wrote:
>> So far the crc16 checksum for a batman-adv broadcast data packet, receiv=
ed
>> on a batman-adv hard interface, was calculated over zero bytes of its
>> content leading to many incoming broadcast data packets wrongly being
>> dropped.
>>
>> This patch fixes this issue by calculating the crc16 over the actual,
>> complete broadcast payload.
>>
>> The issue is a regrission introduced by
>> e5cf86d30a9b32feccb6b866a3f23b0e0483a3b0.
>>
>> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
>
> Hi Linus,
>
> nice catch!! Don't know how much time you spent to find the correct point=
 where
> your broadcast packets were getting lost.. :-)
>
>
> Is it ok for you if we change the commit hash to ("batman-adv: add broadc=
ast
> duplicate check") when merging this patch? Lately Dave complained about c=
ommit
> hashes in patch because it may happen that a developer uses a different h=
ash
> function for his git repo.
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
