Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <13544673.RylKELaqkV@sven-edge>
References: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
 <13544673.RylKELaqkV@sven-edge>
From: dan <dandenson@gmail.com>
Date: Sun, 20 Aug 2017 11:52:24 -0600
Message-ID: <CAA_JP8WCg+FVRdwYrqh-LS4Z52_rNHV5NkZwjRwS7Rksns7h7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] batman on top of vlan?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

thanks.  Just to clarify, batman-adv 32 bytes, so to stack vlans qinq
I need 32+4+4 so 1540 yes?

On Sun, Aug 20, 2017 at 12:55 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Mittwoch, 16. August 2017 09:43:34 CEST dan wrote:
>> Can batman operate on top of a vlan?  For example, a wireless link
>> with MTU of 1532 to accommodate both batman and the vlan.  Plugs into
>> the batman-adv box on eth0, configure eth0.10 and add eth0.10 to bat0.
>
> It should work. batman-adv is not too picky about what is used below it. It
> must be able to transport ethernet frames and it must allow things like
> broadcasts. We could go here into more details but it wouldn't help us to
> answer the question. At least 802.1Q should not influence the behavior in any
> significant way and should therefore not be a problem.
>
> Kind regards,
>         Sven
