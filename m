Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120721213856.GB3610@ritirata.org>
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
 <CAHD-aqK-SrQ0VxmrZSzq3gb_aVZQY5ZYxN7qjdC8dind+jgeuw@mail.gmail.com>
 <20120702143604.GD2917@ritirata.org>
 <CAHD-aq+vsMugkr8CWQaw-bOYzLbxBL6V7zP=cfURNMacyBL+oQ@mail.gmail.com>
 <20120721213856.GB3610@ritirata.org>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sun, 22 Jul 2012 07:57:00 -0300
Message-ID: <CAHD-aqKiFkq_HXBHMERhbv2uS-8ZcxsfVGv_H6asZf3L2Ruq8A@mail.gmail.com>
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

On Sat, Jul 21, 2012 at 6:38 PM, Antonio Quartulli <ordex@autistici.org> wrote:
>> Last week I came across this bug again, with the latest firm which
>> includes the fixes mentioned, pushed by Marek.
>> We were kinda in a hurry so i didn't have much time to check it
>> thoroughly, so there's a *slim* chance it was just a coincidence, such
>> as very poor signal giving erratic results.
>> But if I recall correctly Nico Echaniz did stump on this too, using
>> the latest firm.
>
> How did you solve it then? Rebooting?

A reboot did, yes.

>
>> So, although i can't confirm it 100%, it seems so far the fixes didn't help :(
>>
>> We'll keep an eye on it and try a "batctl l"
>
> Yes, please. Remember to set the TT log level (batctl ll tt) before launching
> batctl l.
> Actually it would be very interesting to see the log of the involved nodes
> during the "wrong behaviour period".

This time it solved itself after some brief time (a minute) but the
symptoms were the same.
So I could catch some logs,
http://pastebin.com/MEENj94i

sadly, i wasn't fast enough to get a live log from the node involved
in the inconsistency as you suggested, so the report might be pretty
useless.
But at least now I got an idea where we are heading :)


> Thank you very much!

Thanks a lot for your support people!

Gui
