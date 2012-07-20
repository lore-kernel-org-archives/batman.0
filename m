Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120702143604.GD2917@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
 <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
 <20120702143604.GD2917@ritirata.org>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Fri, 20 Jul 2012 17:25:46 -0300
Message-ID: <CAHD-aq+vsMugkr8CWQaw-bOYzLbxBL6V7zP=cfURNMacyBL+oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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

Resurrecting thread...

On Mon, Jul 2, 2012 at 11:36 AM, Antonio Quartulli <ordex@autistici.org> wrote:
> Hello!
>
> Has debug support been compiled in batman-adv? IF yes, it would be interesting
> so see the output of the tt log (batctl ll tt; batctl l)
Ah, I should have re-read this before :(


> Recently we fixed a bug that which fix has not been released yet. If we are sure
> that this is the cause, you could eventually try an upgrade to a more recente
> dev-version. But let's see the log first (if possible)
> --
> Antonio Quartulli

Last week I came across this bug again, with the latest firm which
includes the fixes mentioned, pushed by Marek.
We were kinda in a hurry so i didn't have much time to check it
thoroughly, so there's a *slim* chance it was just a coincidence, such
as very poor signal giving erratic results.
But if I recall correctly Nico Echaniz did stump on this too, using
the latest firm.
So, although i can't confirm it 100%, it seems so far the fixes didn't help :(

We'll keep an eye on it and try a "batctl l"

Cheers!

Gui
