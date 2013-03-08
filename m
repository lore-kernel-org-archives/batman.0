Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130308093341.GL1400@ritirata.org>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
 <20130301110809.GC20607@ritirata.org>
 <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
 <20130301114300.GE20607@ritirata.org>
 <CAP5XTDNVPDVD_CXUScqc2D8D4+Xh7NFn=4YM6c8aBmjF7Lbi8A@mail.gmail.com>
 <CAP5XTDNdnZ_-BYJ+1ZtXdoBbh1kD0yD+=Cibs3GG4-yyZbSRzg@mail.gmail.com>
 <20130308093341.GL1400@ritirata.org>
Date: Fri, 8 Mar 2013 12:11:42 +0200
Message-ID: <CAP5XTDM1qdoUM8bhvL1xbWEvurA38SxN2ET4=uQ+vgQ_p_orvg@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Implement DAT for IPv6
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

On 8 March 2013 11:33, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, Mar 08, 2013 at 11:22:37AM +0200, Mihail Costea wrote:
>> Hi,
>>
>> I have created a patch for this, just that is quite big (~ 450 lines
>> the whole patch, with signature, etc). It doesn't contain complex
>> changes, just small changes from __be32 to (unsigned char *), a new
>> parameter to functions in order to give the IP type and added
>> comments.
>>
>> I've tested it with the snooping mechanism I added for IPv6 and it
>> works ok (the snooping mechanism is not in this patch).
>>
>> What I wanted to ask is: it's ok to send a patch this big to the mailing list?
>> I don't see how I could split it more because all I did is changed
>> most of functions signatures and edit the code to support this
>> changes.
>
>
> The common rule is "one change per patch" meaning that if you can logically
> split it (e.g. 1) add this 2) use this there and there 3) improve that) it would
> be better to send more than one patch in one patchset.
> Remember that each and every patch must compile.

I think I could split it into 2-3 parts logically:
1. Add the enum for IP types and add generic functions for comparing,
calculating hash
2. Add generic debug message
3. Modify batadv_dat_entry  and all other functions to support both IPv4/IPv6

Some functions from 1./2. might not be used from start, but only
later, when 3. is done.

>
> Cheers,
>
> p.s. if you want you can send the patch as RFC and see the others say (but
> please try to think about splitting it, if really needed).
>
>>
>> Thx,
>> Mihail
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara



-- 
Mihail Costea
E-mail : mihail.costea90@gmail.com
Telephone : +40725245085
