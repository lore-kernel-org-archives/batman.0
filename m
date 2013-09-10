Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130909145322.GA3979@neomailbox.net>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <20130810110303.GA849@ritirata.org>
 <CAP5XTDMWzo8S086mdmHpgKnGCVWtiJvdHWA=KHa5gFV0H_D5QA@mail.gmail.com>
 <20130810203604.GF849@ritirata.org>
 <CAP5XTDOq8qwsD1b7DcsYb3p5sGwnDE301cLuP-_fnYLE+cz5yA@mail.gmail.com>
 <20130909145322.GA3979@neomailbox.net>
Date: Tue, 10 Sep 2013 07:35:34 +0300
Message-ID: <CAP5XTDPCRj0H3djYsg2pHLDHqSPUqp6faciUF8gpDCOcSp1bRw@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Generalize DAT in order to
 support any type of data, not only IPv4
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

On 9 September 2013 17:53, Antonio Quartulli <antonio@meshcoding.com> wrote:
> On Mon, Sep 09, 2013 at 05:05:47PM +0300, Mihail Costea wrote:
>> Hi Antonio,
>>
>> Is it possible to send the new model for the generalization as a patch
>> first (the part without IPv6), or maybe everything as a patch as once?
>> Having 5-6 patches to rewrite every time something changes makes the
>> development harder.
>
> Which patches do you want to merge?
> If they are ready it is better to send them as PATCH to the ml and then base
> your work on top of them assuming they will be merged at some point.
>

I took a small rest last week and now I'm redoing everything.
I was thinking about sending the first part for merging (the one with
generalization the DAT).
That is the one that needs most rewriting every time because it
affects the most existing code.
The rest I think I can send them together.

> Cheers,
>
> p.s. welcome to the rebase nightmare ;)
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Thanls,
Mihail

-- 
Mihail Costea
