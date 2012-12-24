Return-Path: <paukoning@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201212250337.48595.lindner_marek@yahoo.de>
References: <1353715332-4284-1-git-send-email-sven@narfation.org>
 <201212242237.07208.lindner_marek@yahoo.de>
 <CANiGF98L_Ca20Eb+qVuX1126rWoeqQzOASshB7c2LQ-Fi7DiXA@mail.gmail.com>
 <201212250337.48595.lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 00:18:37 +0100
Message-ID: <CANiGF9_4QP0ts2kV9Bruk_8L7h1870LMcrRhtsYu35q=COF0hQ@mail.gmail.com>
From: Pau Koning <paukoning@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: Move soft-interface
 initialization to ndo_init
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, Sven Eckelmann <sven@narfation.org>

>> What decision? I only see something about Patch 6 and Patch 7: Antonio
>> Quartulli doesn't want rtnetlink support in batman-adv. I don't see
>> any other statement about the rest of the patchset.
>
> Quoting Antonio:
>
>>>>
> Anyway, I discussed about this together with the others and it seems
> that a proper solution now is to wait before merging this patchset and fix the
> current sysfs/rtnl_lock problem first. What do you think?
>
> Adding a new API without fixing the current one doesn't sound like a good
> move.
> <<<
>
> What isn't clear ?

AFAIK patch 6 and 7 are the "new" rtnetlink API. The rest can be
categorized as fixes for bugs and for the wrong way to implementation
things. But I've discussed it with the others and now we found out:
batman-adv doesn't care about the rest of the kernel and bugs are not
relevant compared to egocentric statements.
