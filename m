Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130910053835.GC3979@neomailbox.net>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <20130810110303.GA849@ritirata.org>
 <CAP5XTDMWzo8S086mdmHpgKnGCVWtiJvdHWA=KHa5gFV0H_D5QA@mail.gmail.com>
 <20130810203604.GF849@ritirata.org>
 <CAP5XTDOq8qwsD1b7DcsYb3p5sGwnDE301cLuP-_fnYLE+cz5yA@mail.gmail.com>
 <20130909145322.GA3979@neomailbox.net>
 <CAP5XTDPCRj0H3djYsg2pHLDHqSPUqp6faciUF8gpDCOcSp1bRw@mail.gmail.com>
 <20130910053835.GC3979@neomailbox.net>
Date: Tue, 10 Sep 2013 15:45:44 +0300
Message-ID: <CAP5XTDN4Bzkk4Ek083CJ8nhCqr27BOmfDPsFdCXeFLka-gX9nQ@mail.gmail.com>
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

On 10 September 2013 08:38, Antonio Quartulli <antonio@meshcoding.com> wrote:
> On Tue, Sep 10, 2013 at 07:35:34AM +0300, Mihail Costea wrote:
>> On 9 September 2013 17:53, Antonio Quartulli <antonio@meshcoding.com> wrote:
>> > On Mon, Sep 09, 2013 at 05:05:47PM +0300, Mihail Costea wrote:
>> >> Hi Antonio,
>> >>
>> >> Is it possible to send the new model for the generalization as a patch
>> >> first (the part without IPv6), or maybe everything as a patch as once?
>> >> Having 5-6 patches to rewrite every time something changes makes the
>> >> development harder.
>> >
>> > Which patches do you want to merge?
>> > If they are ready it is better to send them as PATCH to the ml and then base
>> > your work on top of them assuming they will be merged at some point.
>> >
>>
>> I took a small rest last week and now I'm redoing everything.
>> I was thinking about sending the first part for merging (the one with
>> generalization the DAT).
>> That is the one that needs most rewriting every time because it
>> affects the most existing code.
>> The rest I think I can send them together.
>
> I understood. Well, the problem is also that this period is a sort of
> "transition" because batman-adv is getting changed in some of its most important
> part
> and we would like all the "new features" that are not essential to come after
> these changes.
> We still need to merge two (or two and a bit) patchsets before we can start
> merging other things.
>
> This means that before your patchset gets merged we have to wait a bit more.
> I think it would be better to do this:
> - for a while you don't care about rebasing on top  of master
> - when you have a some code ready to be reviewed you can put in on a remote git
>   repo that we can check (e.g. github?)
> - we/I review the code so that we make it ready to be sent as PATCH
> - when these two (and a bit) patchsets are merged you can do the final rebase
>   and send them to the ml for merging.
>
> What do you think?
> In this way we same some painful rebase cycles, but we can continue preparing
> the code.
>

I understand, but it should be done similar? Like multiple patches?
The idea is that I might add some patches and then find a bug that was
in an old patch.
That means to find the patch with the bug, resolve it, and re-patch
everything after it.

It would be easier to do the changes directly on the existing code
than restart everything from scratch.
I'm not sure if this is what you meant by using github.

-- 
Mihail Costea
