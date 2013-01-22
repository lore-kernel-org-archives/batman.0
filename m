Return-Path: <stephen.song@gmail.com>
MIME-Version: 1.0
Sender: stephen.song@gmail.com
In-Reply-To: <CAC0629B-4343-48A8-9321-87A5B2A5B832@lo-res.org>
References: <CAD_CWO3cQMtPns+xzc2hs4sUCmZM1ux4-335rhicUn05Upvu-g@mail.gmail.com>
 <CAD_CWO1hPN=7RVQA+W25oM5nCxxYxV1yefXAYboTvK5_H+hxJg@mail.gmail.com>
 <CAC0629B-4343-48A8-9321-87A5B2A5B832@lo-res.org>
Date: Tue, 22 Jan 2013 13:28:23 -0400
Message-ID: <CAD_CWO0OmDbUXp0A2P4OVzdAHnq+NoRNQ4d4t2H+BXOvCWs6bA@mail.gmail.com>
From: Steve Song <steve@villagetelco.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Advice for dense meshes
Reply-To: steve@villagetelco.org,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Jan, Aaron,

On 22 January 2013 11:37, L. Aaron Kaplan <aaron@lo-res.org> wrote:
>
> On Jan 22, 2013, at 1:54 PM, Steve Song <steve@villagetelco.org> wrote:
>
>> Hi all,
>>
>> A colleague of mine is building a batman-adv mesh network in an
>> apartment building with essentially one node per apartment.   Not
>> surprisingly, results in a very dense mesh with each node having a
>> large number of neighbours.  Here is a typical batctl o output
>> http://pastebin.com/aAR43hj7  This results in some fairly slow
>> connections.
>>
>> I am seeking some general advice on how to optimise batman-adv in the
>> context of a dense mesh.  Options that we have considered include
>> turning the radio transmit power down on all of the devices and/or
>> alternating channels on different floors (e.g.  1,6,11,1,6,11,etc).
>> However, it is not clear to us what is the best strategy in this
>> context.  Grateful for any tips or suggestions you may have.
>>
>> Thanks in advance.... Steve Song
>>
>
> Hi Steve,
>
> The following is my experience.
>
> Optimise layer 1 by:
> *) proper channel assignments
> *) reduce txpower
> *) dont's send when you don't have to send
> *) use spacial separation of frequencies and directionality if possible (ok, this is more of a general advice, won't matter so much in apartments)
> *) most importantly: use 802.11n!

Many thanks both for the practical advice.

For better or worse we are constrained by the fact that this is a Mesh
Potato network which obliges us to put a node in each apartment in
order to provide phone services via the FXS port in the Mesh Potatoes.
 This is not really the kind of network the Mesh Potato was originally
designed for but was chosen for the apartment building over copper
wiring because of the wiring constraints specific to the building.  I
hope we'll be able to optimise this network for adequate performance.

Regards... Steve

-- 
Steve Song
+1 902 529 0046
+27 83 482 2088 (SMS only)
http://villagetelco.org
