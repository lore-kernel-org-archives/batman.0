Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] batctl: Add JSON debug support
From: asarmanow@gmail.com
Date: Wed, 28 Apr 2021 11:40:31 -0000
Message-ID: <20210428114031.12523.14028@diktynna.open-mesh.org>
In-Reply-To: <2557512.EezVJnfClc@sven-l14>
References: <2557512.EezVJnfClc@sven-l14>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Sven Eckelmann wrote:
> On Wednesday, 28 April 2021 12:16:08 CEST Alexander Sarmanow wrote:
> >  Same parameters of the debug tables can be used for
> >  the JSON, except the "-w [interval]" (not useful). The table header is
> >  implemented as a JSON equivalent and can be also optionally omitted.
> >   
> I would like to disagree. Why is it a problem to continuously emit json 
> objects? 
Simon agreed with me to leave that out, but I can add it and the user can decide whether to use it or not. It does not disturb.

> >  --- a/netlink.c
> >  +++ b/netlink.c
> >  @@ -318,15 +318,29 @@ static int info_callback(struct nl_msg *msg, void *arg)
> >                  else
> >                          extra_header = "";
> >   
> >  -               ret = asprintf(&opts->remaining_header,
> >  -                              "[B.A.T.M.A.N. adv %s, MainIF/MAC:
> > %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
> >  -                              version, primary_if,
> >  -                              primary_mac[0], primary_mac[1], primary_mac[2],
> >  -                              primary_mac[3], primary_mac[4], primary_mac[5],
> >  -                              mesh_name,
> >  -                              mesh_mac[0], mesh_mac[1], mesh_mac[2],
> >  -                              mesh_mac[3], mesh_mac[4], mesh_mac[5],
> >  -                              algo_name, extra_info, extra_header);
> >  +               if (opts->is_json) {
> >  +                       ret = asprintf(&opts->remaining_header,
> >  +                                     
> > "{\"version\":\"%s\",\"main_if\":\"%s\",\"main_mac\":\"%02x:%02x:%02x:%02x:%02x:%02x\",\"mesh_if\":\"%s\",\"mesh_mac\":\"%02x:%02x:%02x:%02x:%02x:%02x\",\"algo_name\":\"%s\",\"extra_info\":\"%s\",\"data\":[",
> >  +                                      version, primary_if,
> >  +                                      primary_mac[0], primary_mac[1],
> >  +                                      primary_mac[2], primary_mac[3],
> >  +                                      primary_mac[4], primary_mac[5],
> >  +                                      mesh_name,
> >  +                                      mesh_mac[0], mesh_mac[1], mesh_mac[2],
> >  +                                      mesh_mac[3], mesh_mac[4], mesh_mac[5],
> >  +                                      algo_name, extra_info);
> >  +               } else {
> >  +                       ret = asprintf(&opts->remaining_header,
> >  +                                      "[B.A.T.M.A.N. adv %s, MainIF/MAC:
> > %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
> >  +                                      version, primary_if,
> >  +                                      primary_mac[0], primary_mac[1],
> >  +                                      primary_mac[2], primary_mac[3],
> >  +                                      primary_mac[4], primary_mac[5],
> >  +                                      mesh_name,
> >  +                                      mesh_mac[0], mesh_mac[1], mesh_mac[2],
> >  +                                      mesh_mac[3], mesh_mac[4], mesh_mac[5],
> >  +                                      algo_name, extra_info, extra_header);
> >  +               } 
> Do we really have to add such kind of output to each table? Can't we just have 
> another command to get the meshif info and print it?
You are right. I just followed the existing debug tables where the header is also always printed out each time and there is no separate command for that. But I can create a separate command to fetch the "header".

Best,
Alex
