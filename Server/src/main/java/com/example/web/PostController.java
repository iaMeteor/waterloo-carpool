package com.example.web;
import com.example.domain.Post;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RequestMapping("/posts")
@Controller
@RooWebScaffold(path = "posts", formBackingObject = Post.class)
@RooWebJson(jsonObject = Post.class)
public class PostController {
}
