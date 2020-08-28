Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Chuck Ritola <cjritola@gmail.com>
Date: Fri, 28 Aug 2020 18:00:59 -0400
Message-ID: <CA+RexfHNV+HY28OiuHKNy4Rn=MM4gxOU0xCiVG0z56dfnv_z6g@mail.gmail.com>
Subject: Is it possible to send all batman-adv traffic through http proxy cache?
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Is it possible to send all batman-adv ethernet traffic through an HTTP
proxy cache such as Squid?

This is for building a fairly large mesh network on amateur radio with
some links having limited bandwidth. To improve performance a proxy
cache would be installed inside each node, which stores to cache any
HTTP responses tagged as cacheable and sniffs for HTTP requests
through said switch for requests matching any cache entry. It then
blocks the request from being forwarded and responds to the request
itself with the cached data.

I'm having difficulty figuring out how to get batman-adv to pass all
of its raw ethernet traffic (presumably with mesh headers removed)
through outside software such as Squid before performing its
switching.

Another consideration was ALFRED but it doesn't appear to be easily
integratable with existing software.
