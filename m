Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130504113919.GD3773@ritirata.org>
References: <1366984615-15429-1-git-send-email-mihail.costea2005@gmail.com>
 <20130504113919.GD3773@ritirata.org>
Date: Mon, 6 May 2013 14:48:20 +0300
Message-ID: <CAP5XTDMxVn7r5_+drZ1CMAUDS3f_AeO9-OgJ5UQEyzS82cq8FQ@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH] Made DAT more generic by adding support
 to any type of data
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

On 4 May 2013 14:39, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, Apr 26, 2013 at 04:56:54 +0300, Mihail wrote:
>> From: Mihail Costea <mihail.costea90@gmail.com>
>>
>> Made DAT support more types by making its data a void*, adding type field
>> to dat_entry and adding data_type to necessary functions.
>> This change is needed in order to make DAT support any type of data, like IPv6 too.
>>
>> Added generic function for transforming DAT data to string.
>> The function is used in order to avoid defining different debug messages
>> for different DAT data types. For example, if we had IPv6 as a DAT data,
>> then "%pI4" should be "%pI6c", but all
>> the other text of the debug message would be the same.
>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
>> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>
> Hi Mihail,
>
> as discussed on IRC this patch is now pretty mature and looks very good!
> Also other devs have read it and were happy about the work done so far.
>
> However the idea is to wait and merge this patch together with the IPv6
> mechanism, so that we don't only introduce this generalisation, but we also use
> it (Bloating the kernel with something cool that is not exploited is not a good
> idea..).
>
> Hence we will be happy to to wait and review the IPv6 mechanism as soon as you
> can send it over the ml.
>
> While discussing this patch I imagine you learnt a lot of things which may
> help you in polishing the code that is going to come :)
>
>
> Let us know when the IPv6 part is ready to be reviewed! We are all eager to
> introduce and use this new feature!
>
>
> Cheers (have a nice Saturday),
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

Hi Antonio,

Thanks for the update.
Now I'm at the countryside because we have the Easter holiday :). Next
week I'll be out relaxing too, so I will start working on polishing
the code on 12-13 May. I think that I should be able to have the patch
ready that week.

Sorry about the late answer, but it seems the phone sent the email as
html even if I selected respond inline.

Cheers,
Mihail


--
Mihail Costea
